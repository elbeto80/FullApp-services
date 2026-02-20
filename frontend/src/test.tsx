import { useState } from "react";
import axios from "axios";

interface Post {
  id: number;
  title: string;
  body: string;
}

function App() {
  const [data, setData] = useState<Post[] | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchPosts = async () => {
    setLoading(true);
    setError(null);
    setData(null);
    try {
      const response = await axios.get(`${VITE_API_BASE_URL}/posts`);
      setData(response.data);
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Error al cargar los datos",
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ padding: "2rem", maxWidth: 600, margin: "0 auto" }}>
      <h1>Prueba de API externa</h1>
      <p style={{ color: "#666", marginBottom: "1rem" }}>
        JSONPlaceholder – posts de ejemplo (sin API key).
      </p>
      <button
        onClick={fetchPosts}
        disabled={loading}
        style={{
          padding: "0.5rem 1rem",
          fontSize: "1rem",
          cursor: loading ? "not-allowed" : "pointer",
          backgroundColor: "#0d6efd",
          color: "white",
          border: "none",
          borderRadius: 6,
        }}
      >
        {loading ? "Cargando…" : "Cargar posts"}
      </button>

      {error && (
        <p style={{ color: "#c00", marginTop: "1rem" }}>Error: {error}</p>
      )}

      {data && (
        <ul style={{ marginTop: "1.5rem", paddingLeft: "1.25rem" }}>
          {data.map(post => (
            <li key={post.id} style={{ marginBottom: "0.75rem" }}>
              <strong>{post.title}</strong>
              <br />
              <span style={{ color: "#555", fontSize: "0.9rem" }}>
                {post.body}
              </span>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default App;
