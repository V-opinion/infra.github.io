export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    if (request.method === "GET" && url.pathname === "/health") {
      return json({ ok: true, service: "indexer" });
    }

    if (request.method === "POST" && url.pathname === "/submit") {
      const body = await request.json().catch(() => ({}));
      const targetUrl = body.url;

      if (!targetUrl) {
        return json({ ok: false, error: "Missing url" }, 400);
      }

      const id = crypto.randomUUID();
      const job = {
        id,
        url: targetUrl,
        status: "queued",
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      await env.STATE.put(`job:${id}`, JSON.stringify(job));
      await env.CONTENT.put(`latest:${id}`, JSON.stringify({ url: targetUrl }));

      return json({ ok: true, job });
    }

    if (request.method === "GET" && url.pathname.startsWith("/status/")) {
      const id = url.pathname.split("/").pop();
      const raw = await env.STATE.get(`job:${id}`);
      if (!raw) return json({ ok: false, error: "Not found" }, 404);
      return new Response(raw, { headers: { "content-type": "application/json" } });
    }

    return json({ ok: false, error: "Not found" }, 404);
  },

  async scheduled(event, env, ctx) {
    const payload = {
      ran_at: new Date(event.scheduledTime).toISOString(),
      cron: event.cron || ""
    };
    await env.STATE.put("scanner:last_run", JSON.stringify(payload));
  }
};

function json(data, status = 200) {
  return new Response(JSON.stringify(data, null, 2), {
    status,
    headers: { "content-type": "application/json; charset=utf-8" }
  });
}
