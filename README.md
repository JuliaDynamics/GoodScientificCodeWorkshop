# Good Scientific Code Workshop
![](Good_Scientific_Code_logo.png)

[![DOI](https://zenodo.org/badge/515197201.svg)](https://zenodo.org/badge/latestdoi/515197201)

**Table of Contents**
1. [Elevator Pitch](#elevator-pitch)
2. [Information](#information)
3. [Contents](#contents)
4. [Bring your own code!](#bring-your-own-code)
5. [YouTube recording](#youtube-recording)
6. [Citing](#citing)


## Elevator Pitch

> _Scientific code is notorious for being hard to read and navigate, difficult to reproduce, and badly documented. One reason leading to this situation is that curricula that traditionally train scientists do not explicitly treat writing good code, and during the scientific life there is little time for the individual to practice this on their own. In this intensive block-based-workshop we will change that and teach you all you need to know to write code that is **Clear, Easy to understand, Well-documented, Reproducible, Testable, Reliable, Reusable, Extendable, and Generic.**_
>
> _Sounds too good to be true…? Join this workshop, and you will be surprised to find out that attributing all these properties to your code does not take much effort; once you have the proper education on the subject, you get all of this good stuff practically for free!_

## Information

This repository contains the materials (presentation slides and exercises) for the "Good Scientific Code" workshop. Powerpoint version of the slides (for editing) is available on demand.

The workshop is (mostly) language-agnostic, meaning that the principles are about general coding. Examples and exercises will be in Julia and Python.
It is structured as an intensive six-blocks course, aimed to be performed with tutors overseeing the exercises parts and helping the students. Students and their tutors are recommended to go through each block, one by one, and spend as much time as necessary until the students have understood the block and were able to solve all exercises (especially the application to their own code, see below). The expected time span for this to happen is about a day or two for each block.

This workshop was developed over 3 years by [George Datseris](https://github.com/Datseris/), combining textbooks, other workshops, online tutorials from field experts, blog posts, personal experience developing and documenting 10+ software, and research on how to make reproducible science.

[Lukas Kluft](https://github.com/lkluft/) helped the workshop substantially by providing Python examples, translating Julia code to Python, reviewing the slides, and being a tutor during a live version.

## Contents

The workshop is divided into the following six blocks:

- **Version control**: retraceable and safe code history using git
- **Clear code**: write code that is easy to understand and reason for
- **Software developing paradigms**: write your code like a software developer
- **Collaboration & publishing code**: modern team-based code development on GitHub
- **Documenting software**: documentation that conveys information efficiently and intuitively
- **Scientific project reproducibility**: publish reproducible papers

## Bring your own code!

The exercise sessions have two components. On the first, illustrative but simple exercises are given to the participants to practice each topic. Participants are expected to solve the exercises live during the workshop! The second component requires the participants to apply this new knowledge to their very own code base. Therefore, please bring along all code you have used in your latest published paper. If you haven't published yet, no worries, bring along all the code you have at the moment for your science project. Decide in advance on 2-3 figures of your paper/project, which will be the central focus of the exercises. The exercise plan will transform your code from random scripts to a self-contained code base that is understandable, extendable, continuously tested, documented, and hosted on open and accessible platforms.

_Note: for this plan to have meaningful impact, you should bring a code base where you had to write a substantial amount of source code._

## YouTube recording

A video recording of the live version of this workshop, performed at the Max Planck Institute for Meteorology, is available on YouTube: https://youtu.be/x3swaMSCcYk .

## Citing

You can cite this material using the DOI 10.5281/zenodo.7789872, or the following BibTeX entry:

```
@software{goodscientificcode,
  author       = {George Datseris},
  title        = {{Good scientific code workshop}},
  month        = mar,
  year         = 2023,
  publisher    = {Zenodo},
  version      = {v1.0},
  doi          = {10.5281/zenodo.7789871},
  url          = {https://doi.org/10.5281/zenodo.7789871}
}
```

