"use strict";

// The links and navigation work without JavaScript. Enhance each feature separately.
const menuToggle = document.querySelector(".menu-toggle");
const navigation = document.querySelector(".main-nav");

if (menuToggle && navigation && typeof window.matchMedia === "function") {
  const mobileNavigation = window.matchMedia("(max-width: 900px)");
  const menuIcon = menuToggle.querySelector("use");

  function setNavigation(open, restoreFocus = false) {
    navigation.classList.toggle("is-open", open);
    menuToggle.setAttribute("aria-expanded", String(open));
    menuToggle.setAttribute("aria-label", open ? menuToggle.dataset.closeLabel : menuToggle.dataset.openLabel);
    if (menuIcon) menuIcon.setAttribute("href", open ? "#i-close" : "#i-menu");
    if (restoreFocus && mobileNavigation.matches) menuToggle.focus({ preventScroll: true });
  }

  menuToggle.addEventListener("click", () => {
    setNavigation(menuToggle.getAttribute("aria-expanded") !== "true");
  });

  navigation.querySelectorAll("a").forEach((link) => {
    link.addEventListener("click", () => {
      if (!mobileNavigation.matches) return;
      const target = link.hash && link.pathname === window.location.pathname
        ? document.getElementById(link.hash.slice(1)) : null;
      const focusWasInNavigation = navigation.contains(document.activeElement);
      setNavigation(false, focusWasInNavigation && !target);
      if (target) target.focus({ preventScroll: true });
    });
  });

  document.addEventListener("click", (event) => {
    if (navigation.classList.contains("is-open")
      && !navigation.contains(event.target) && !menuToggle.contains(event.target)) {
      setNavigation(false, navigation.contains(document.activeElement));
    }
  });

  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && navigation.classList.contains("is-open")) {
      event.preventDefault();
      setNavigation(false, true);
    }
  });

  const onNavigationResize = () => {
    const focusWasInNavigation = navigation.contains(document.activeElement);
    const focusWasOnToggle = document.activeElement === menuToggle;
    setNavigation(false, focusWasInNavigation);
    if (!mobileNavigation.matches && focusWasOnToggle) navigation.querySelector("a")?.focus();
  };
  if (mobileNavigation.addEventListener) mobileNavigation.addEventListener("change", onNavigationResize);
  else mobileNavigation.addListener(onNavigationResize);

  // Only collapse the no-JS navigation after all of its controls are initialized.
  document.documentElement.classList.add("nav-enhanced");
}

document.querySelectorAll(".language-link").forEach((link) => {
  link.addEventListener("click", () => {
    const destination = new URL(link.href);
    destination.hash = window.location.hash;
    link.href = destination.href;
  });
});

const screenshotDialog = document.querySelector("#screenshot-dialog");
const screenshotImage = document.querySelector("#screenshot-image");
const screenshotCaption = document.querySelector("#screenshot-caption");
const screenshotStatus = document.querySelector("#screenshot-status");
const dialogClose = document.querySelector(".dialog-close");

if (screenshotDialog && typeof screenshotDialog.showModal === "function"
  && screenshotImage && screenshotCaption && screenshotStatus && dialogClose) {
  let lastScreenshotTrigger = null;

  document.querySelectorAll(".screenshot-trigger").forEach((trigger) => {
    trigger.setAttribute("aria-haspopup", "dialog");
    trigger.addEventListener("click", (event) => {
      // Keep normal new-tab and download gestures available on the image links.
      if (event.ctrlKey || event.metaKey || event.shiftKey || event.altKey || event.button !== 0) return;
      lastScreenshotTrigger = trigger;
      screenshotStatus.textContent = "";
      screenshotImage.alt = trigger.querySelector("img")?.alt || "";
      screenshotCaption.textContent = trigger.dataset.caption;
      screenshotImage.src = trigger.href;
      try {
        screenshotDialog.showModal();
      } catch {
        return; // The original image link remains the fallback if opening fails.
      }
      event.preventDefault();
      document.body.classList.add("modal-open");
    });
  });

  screenshotImage.addEventListener("error", () => {
    screenshotStatus.textContent = screenshotStatus.dataset.errorLabel;
  });
  screenshotImage.addEventListener("load", () => {
    screenshotStatus.textContent = "";
  });

  dialogClose.addEventListener("click", () => screenshotDialog.close());
  screenshotDialog.addEventListener("click", (event) => {
    if (event.target !== screenshotDialog) return;
    const bounds = screenshotDialog.getBoundingClientRect();
    const clickedOutside = event.clientX < bounds.left || event.clientX > bounds.right
      || event.clientY < bounds.top || event.clientY > bounds.bottom;
    if (clickedOutside) screenshotDialog.close();
  });
  screenshotDialog.addEventListener("close", () => {
    document.body.classList.remove("modal-open");
    lastScreenshotTrigger?.focus({ preventScroll: true });
  });
}
