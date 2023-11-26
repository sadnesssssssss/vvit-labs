const portfolio = document.querySelector(".portfolio-interactive");
const portfolioBtn = document.querySelector(".portfolio-btn");
function togglePortfolioVisibility() {
portfolio.classList.toggle("hide");
}
portfolioBtn.addEventListener("click", togglePortfolioVisibility);