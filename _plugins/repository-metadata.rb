require "json"
require "net/http"
require "uri"

module RepositoryMetadata
  class RepositoryMetadataGenerator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      data = site.data["repositories"] || {}
      repos = data["repositories"] || []
      profile = data["profile"] || {}

      site.data["repo_api"] = {}
      site.data["repo_profile_api"] = {}

      fetch_profile(site, profile["username"])
      fetch_repositories(site, repos)
    end

    private

    def fetch_profile(site, username)
      return if username.nil? || username.strip.empty?

      payload = get_json("https://api.github.com/users/#{username}")
      return if payload.nil?

      site.data["repo_profile_api"] = {
        "name" => payload["name"],
        "bio" => payload["bio"],
        "followers" => payload["followers"],
        "public_repos" => payload["public_repos"],
        "html_url" => payload["html_url"],
      }
    end

    def fetch_repositories(site, repos)
      repos.each do |repo|
        slug = repo["slug"]
        next if slug.nil? || slug.strip.empty?

        payload = get_json("https://api.github.com/repos/#{slug}")
        next if payload.nil?

        site.data["repo_api"][slug] = {
          "description" => payload["description"],
          "stargazers_count" => payload["stargazers_count"],
          "forks_count" => payload["forks_count"],
          "language" => payload["language"],
          "updated_at" => payload["updated_at"],
          "html_url" => payload["html_url"],
        }
      end
    end

    def get_json(url)
      uri = URI.parse(url)
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["User-Agent"] = "kennethqngo-site-builder"
      request["X-GitHub-Api-Version"] = "2022-11-28"

      token = ENV["GITHUB_TOKEN"]
      request["Authorization"] = "Bearer #{token}" unless token.nil? || token.strip.empty?

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      return JSON.parse(response.body) if response.code.to_i == 200

      Jekyll.logger.warn("repo-metadata", "GitHub API #{response.code} for #{url}")
      nil
    rescue StandardError => e
      Jekyll.logger.warn("repo-metadata", "Failed for #{url}: #{e.message}")
      nil
    end
  end
end
