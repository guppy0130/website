---
layout: default
css: index
---

Hello,

# My name is Nicholas Yang.

<h1>Let's make something <span class="typed"></span></h1>

Want to build something? Let's make it happen.

California-based aspiring developer/photographer looking to make a meaningful difference.

## Recent Posts

{% for post in site.posts limit:5 %}
{% include post.html post=post %}
{% endfor %}

<script>
function typed() {
    new Typed('.typed', {
        strings: [
            'new.',
            'exciting.',
            'better.',
            'look good.',
            'creative.',
            'that works.'
        ],
        typeSpeed: 40,
        loop: true,
        backDelay: 1000,
        backSpeed: 30,
        shuffle: true
    });
}

function hasLocalStorage() {
    try {
        storage = window.localStorage;
        var x = '__storage_test';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    } catch(e) {
        return false;
    }
}

let version = 'v1'
let cacheName = `cache-${version}`

if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/sw.js', {
        scope: '/'
    });

    if (hasLocalStorage()) {
        // if we do not have the localStorage, don't bother registering the
        // cache magic
        navigator.serviceWorker.onmessage = function(event) {
            var message = JSON.parse(event.data);
            console.log('received', message);
            if (message.type !== 'refresh') {
                // not an update. no need to refresh.
                return;
            }
            if (message.eTag === localStorage.getItem(message.url)) {
                // not an update for this item. no need to refresh.
                // getItem() returns null for something it doesn't have.
                return;
            }
            // at this point, something should be updatable.
            // update localStorage with the url, eTag
            localStorage.setItem(message.url, message.eTag);
            console.log(message);
        };
    }
}

</script>
<script src="https://cdn.jsdelivr.net/npm/typed.js@2.0.11" integrity="sha256-SbjNN9cJzRfdpoa82bqXKC5uMg+oqbWvVAzPlubCdNc=" crossorigin="anonymous" async defer onload="typed()"></script>
