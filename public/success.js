document.addEventListener("DOMContentLoaded", () => {
  const params = new URLSearchParams(window.location.search);
  document.getElementById("request-id").textContent = params.get("requestId");
  console.log("hello");
  const requestId = params.get("requestId");
  console.log("Success File ", requestId);
});
