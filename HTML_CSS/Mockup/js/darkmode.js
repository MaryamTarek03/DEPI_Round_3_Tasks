// Dark Mode Toggle Functionality
class DarkModeToggle {
  constructor() {
    this.toggleButton = document.getElementById("darkModeToggle");
    this.body = document.body;
    this.darkModeKey = "darkMode";

    this.init();
  }

  init() {
    const savedTheme = localStorage.getItem(this.darkModeKey);

    if (savedTheme === "dark") {
      this.enableDarkMode();
    } else {
      this.enableLightMode();
    }

    this.toggleButton.addEventListener("click", () => this.toggleDarkMode());
  }

  toggleDarkMode() {
    const currentTheme = document.documentElement.getAttribute("data-theme");

    if (currentTheme === "dark") {
      this.enableLightMode();
    } else {
      this.enableDarkMode();
    }
  }

  enableDarkMode() {
    document.documentElement.setAttribute("data-theme", "dark");
    this.toggleButton.textContent = "☀️";
    localStorage.setItem(this.darkModeKey, "dark");
  }

  enableLightMode() {
    document.documentElement.setAttribute("data-theme", "light");
    this.toggleButton.textContent = "🌙";
    localStorage.setItem(this.darkModeKey, "light");
  }
}

document.addEventListener("DOMContentLoaded", () => {
  new DarkModeToggle();
});