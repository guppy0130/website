let version = 'v1'
let cacheName = `cache-${version}`
let files = [
    '/',
    '/assets/css/index.css',
    '/assets/css/main.css',
    '/assets/fonts/iosevka-heavy.woff2'
]

self.addEventListener('install', event => {
    event.waitUntil(caches.open(cacheName).then(cache => {
        cache.addAll(files)
    }));
});

async function update(request) {
    /* make a request + update cache */
    const cache = await caches.open(cacheName);
    const response = await fetch(request);
    if (response.status === 200) {
        await cache.put(request, response.clone());
    }
    return response;
}

async function fromCache(request) {
    /* try to get something from cache. if it fails, ask the network. */
    const cache = await caches.open(cacheName);
    return await cache.match(request) || update(request);
}

async function refresh(response) {
    /* notify the client that an update is ready */
    await self.clients.matchAll().then(clients => {
        clients.forEach(client => {
            const message = {
                type: 'refresh',
                url: response.url,
                eTag: response.headers.get('ETag')
            };
            client.postMessage(JSON.stringify(message))
        });
    });
    return response;
}

self.addEventListener('fetch', event => {
    // don't bother caching livereload requests
    // don't bother caching things not in our domain
    const request = event.request;
    const requestURL = new URL(request.url);
    if (request.url.includes('livereload') || requestURL.hostname !== location.hostname) {
        event.respondWith(fetch(request));
        return;
    }
    // respond immediately. Updates can wait, who cares?
    event.respondWith(fromCache(request));
    update(request).then(refresh);
});
