---
layout: default
css: index
---

Hello,

# My name is Nicholas Yang.

<h1 class="typed-prefix">Let's make something<span class="typed"></span></h1>

Want to build something? Let's make it happen.

California-based developer/photographer looking to make a meaningful difference.

## [Recent Posts](/blog/)

{% for post in site.posts limit:5 %}
{% include post.html post=post %}
{% endfor %}

<script>
function typed() {
    new Typed('.typed', {
        strings: [
            'new',
            'exciting',
            'better',
            'look good',
            'creative',
            'that works'
        ],
        typeSpeed: 40,
        loop: true,
        backDelay: 1000,
        backSpeed: 30,
        shuffle: true,
        onBegin: (self) => {
            self.el.classList.add('typing');
        },
        onDestroy: (pos, self) => {
            self.el.classList.remove('typing');
        },
    });
}

</script>
<script src="https://cdn.jsdelivr.net/npm/typed.js@2.0.11" integrity="sha256-SbjNN9cJzRfdpoa82bqXKC5uMg+oqbWvVAzPlubCdNc=" crossorigin="anonymous" async defer onload="typed()"></script>
