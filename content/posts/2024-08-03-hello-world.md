+++
title="on the swe/developer to physical task pipeline"

[extra]
tldr="it isn't easier, but it's more obvious? maybe there's also a physical/irl result of your work"
+++

> yeah sheep 5 is ready for shearing so maybe I'll try to get to that today

<!--more-->

I'll prefix all this with the admission that this is all speculation and I've
never sheared a sheep or farmed my own crops. well, maybe if you consider
propagating green onion ends in water "farming". maybe you shouldn't.

## on accessibility and complexity

maybe this is two-fold? there's operational complexity (e.g., "how do I make
this thing work in our existing infra") and there's development complexity
("how do I make this").

the accessibility part of this is, like, "wow, the complexity doesn't make using
these tools easy?"

or maybe I'm just more used to kubernetes at home

### re: operational complexity

kubernetes is easy compared to some of the operational magic that goes on
internally! imagine you are told the following:

* there's this business-critical piece of infra that runs on certain hosts
* said piece of infra runs controller/agent and you can only have one controller
* there's no automatic failover
* datacenter ops needs to do some physical work on one of these hosts

at this point you should be like, wait, hold on:

* just stick raft in this and solve the `one controller/auto-failover` problem
* what happens if the controller disappears

and then the more experienced people on your team say:

* modify the start/stop controller schedule by hand to ensure always one up
* don't forget to run certain command so that new controller knows it should be
  the controller

not sure if we've traded software/development complexity for operational
complexity here, because both are slightly difficult now!

maybe the equivalent is figuring out if your crop belongs in a certain kind of
soil or whatever? but there's no failover for plants/farming; either the crop
grows and you harvest it, or you don't?

### re: operational complexity 2

someone cooked an app and they want to send it to prod, but it doesn't follow
standards that the prod-app-release-team have set, and, well, you're part of the
prod-app-release-team and you gotta deploy it anyways because there'll be
business impact if you don't! so now you gotta reconfigure a chunk of your dev
tooling to support New Funny App without breaking deployments for Well-Behaved
Apps

sometime this week I found someone `scp`-ing binaries to prod by hand, never
mind change controls or consistent deployment strategies so that we can track it
and know

* where it should be
* when it should be running
* if it dies

maybe some random passerby/tourist will shear a sheep for you or plant a crop in
your field? but like, who would do that?

### re: development complexity

ok this kinda ties back into the previous takes, but part of the
prod-app-release-team responsibility is "which host does this thing run on" and
"when should it be alive," two questions that are, funnily enough, hard to solve
once you have multiple scheduling systems and multiple deployment systems. so,
while there's this really long trek on converting apps to one standard
deployment system (don't even get me started on trying to get people to agree on
a scheduling system), it's someone's task to cook a single pane of glass that
reads from the variety of deployment and scheduling services and aggregate all
that data into a single DB.

somewhat reasonable if you expect that you're not getting rid of the variety of
deployment and scheduling strategies anytime soon, I guess. it's a operational
boon to know where something is running if there's physical work that needs to
be done on a certain host and your app needs that particular host for some
hardware reasons or something. or maybe that's what kubernetes annotations are
supposed to solve, but what do I know? I'm the lowest on the totem pole.

anyways cooking this app takes a while but it gets out there, and then the lead
developer fucks off to the woods forever, probably because they've _also_ seen
some shit, and your team is like "wow uh so now how to do we support this," and
now there's a v2 planned which is a from-scratch rewrite, and!

### re: development complexity 2

there's just no getting away from the fact that as your needs grow more niche
(you're optimizing for niche cases, you're supporting one team with something
slightly nonstandard, etc.), your complexity grows. we tried to address this
with templated repositories that provide basics for docs/cli/testing, and while
there's been some adoption (and migration of existing codebases!), there's also
some new projects that don't start from it (despite being able to). the authors
aren't unaware of the template, mind you; it's just easier for them to start on
their template (maybe they're more familiar with it) and then leave it up to us
to convert it into our template.

I don't know, are there different ways to shear a sheep? there's probably
different ways of planting crops I guess but at the end of the day it's still
seed-in-ground then water-occasionally and then wow! plant!

## on meetings

there's plenty of pre-existing literature on how meetings affect developers, and
I probably agree with the ones that are like "less meetings = more dev time",
but I found it kinda funny when one of the Very Important People (who, mind you,
may have been a developer at one point before they became a manager) was taking
an article about `developers need time to work on things and that means less
meetings` as gospel and was telling their friends about it? like, yeah, you used
to be a developer too I think?

ok, I'll preface _this_ with the note that I have this unfounded, unrealistic
expectation that you rise in "rank" or whatever in corporate america due to
merit? but "wow yeah you're such a good developer, here have `team tech lead` as
your new title and participate in 10x more meetings" is absolutely silly.

but anyways, this expectation makes me feel like "ok, you're my boss, or
somewhere up in the management chain, you should have an idea of what I'm
working on (reasonable) and if I have questions or design decisions that need to
be made I expect you to be the one to help answer these (also sorta
reasonable?). it'd be nice if you could also answer technical questions but if
you can't, that's ok, hopefully my team of new grads can (that's not an attack
on your ego, but if you felt that it was, maybe it's just time to skill up)"

perhaps the last part was a little confrontational. how would I feel if I were
told `skill issue` in the workplace? well, if they have a point...

I think bigger swe-focused corps have this separation of a tech lead (read:
someone who can deal with the technical aspect of the work) and the more
traditional HR-like manager (click the "approve time off" button in workday,
ensure you're not burning out, both also very important tasks) for this reason?
but does that mean you have twice the meetings because you have twice the
"managers"?

See also:

* [meetings-tier-chart](@/posts/2024-08-04-meetings-tier-chart.md)
