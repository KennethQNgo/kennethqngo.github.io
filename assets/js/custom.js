(function () {
  "use strict";

  function markRevealTargets() {
    const selectors = [
      ".revamp-home .post-header",
      ".revamp-home .clearfix > p",
      ".revamp-home h2",
      ".revamp-home .news tr",
      ".revamp-home .social",
      ".revamp-blog .header-bar",
      ".revamp-blog .featured-posts .col",
      ".revamp-blog .blog-list-item",
      ".revamp-blog .pagination",
      ".revamp-post .post-header",
      ".revamp-post #markdown-content > p",
      ".revamp-post #markdown-content > h2",
      ".revamp-post #markdown-content > h3",
      ".revamp-post #markdown-content > ul",
      ".revamp-post #markdown-content > ol",
      ".revamp-post #markdown-content > blockquote",
      ".revamp-post #markdown-content > pre",
      ".revamp-post #markdown-content > figure",
      ".revamp-post #markdown-content > table",
    ];

    const targets = document.querySelectorAll(selectors.join(","));
    targets.forEach((el, index) => {
      if (!el.classList.contains("reveal")) {
        el.classList.add("reveal");
      }
      el.style.transitionDelay = `${Math.min(index * 18, 160)}ms`;
    });
    return targets;
  }

  function initializeReveal() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      return;
    }

    const targets = markRevealTargets();
    if (!targets.length) {
      return;
    }

    if (!("IntersectionObserver" in window)) {
      targets.forEach((el) => el.classList.add("reveal-in"));
      return;
    }

    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("reveal-in");
            observer.unobserve(entry.target);
          }
        });
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.1 }
    );

    targets.forEach((target) => observer.observe(target));
  }

  document.addEventListener("DOMContentLoaded", initializeReveal);
})();
