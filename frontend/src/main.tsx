import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import "@styles/tailwind.css";
import App from "@/App";
// import Test from "@/test";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <App />
    {/* <Test /> */}
  </StrictMode>,
);
