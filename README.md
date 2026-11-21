# Readers' Haven Public Library

A small static website for Readers' Haven, a fictional city public library.
It helps residents discover the library's book collections, membership plans,
digital services, and contact details.

This repository is the DevOps Fundamentals (SEST4663) Assignment 02 project:
the site is built with Parcel and packaged into a small multi-stage Docker
image, so the library's IT staff can run the exact same website on any
machine with a single `docker container run` command.

## Pages

- `src/index.html` — Home: mission, location, opening hours
- `src/collections.html` — Book collections and featured titles
- `src/membership.html` — Membership plans and borrowing rules
- `src/services.html` — Digital services (catalogue, e-books, study rooms)
- `src/contact.html` — Address, phone, email, and a feedback form

All pages are plain HTML and CSS, styled by the shared `styles/style.css`.
Node.js and Parcel are build tools only; there is no backend.

## Build the site locally

```bash
npm ci
npm run build
```

The built site is generated in `dist/`. Never commit `dist/` — it is
regenerated on every build.

## Build and run the Docker image

```bash
docker image build -t <dockerhub-username>/readers-haven-final:v2.0 .
docker container run -d --name haven-library -p 8081:80 <dockerhub-username>/readers-haven-final:v2.0
```

Then open http://localhost:8081 in a browser.

## Branches

- `main` — production-ready code
- `develop` — integration branch for feature work
- `feature/<page-name>` — one branch per page, merged into `develop` by pull request
- `release/v2.0` — final testing before the release to `main`
