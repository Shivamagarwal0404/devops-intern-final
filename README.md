# DevOps Intern Final Assessment

This project is part of my DevOps internship assessment. I worked on Linux shell scripting, Docker, NGINX, GitHub Actions, Nomad, and monitoring tools.

The main goal was to build a small web application, test it, and understand how these tools work together in a DevOps workflow.

## Tools Used

- Linux and Bash
- Docker
- NGINX
- Git and GitHub
- GitHub Actions
- GitHub Container Registry (GHCR)
- HashiCorp Nomad
- Consul
- Grafana, Loki, and Promtail

## Project Structure

```text
.
├── app/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
├── scripts/
│   ├── sysinfo.sh
│   └── healthcheck.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── nomad/
│   ├── agent-dev.hcl
│   └── nginx-app.nomad.hcl
├── monitoring/
│   ├── docker-compose.yml
│   ├── loki-config.yml
│   ├── promtail-config.yml
│   └── grafana/
├── docs/
│   └── screenshots/
│       └── grafana-explore.png
└── README.md
```

## 1. Shell Scripts

I created two Bash scripts:

- `sysinfo.sh` displays system information.
- `healthcheck.sh` checks whether an HTTP endpoint is responding.

Run the scripts using:

```bash
chmod +x scripts/*.sh
./scripts/sysinfo.sh
./scripts/healthcheck.sh
```

I also checked the scripts with ShellCheck.

## 2. Docker and NGINX

I created a Docker image for an NGINX web application. The server listens on port `8080`, runs as a non-root user, and has a health check.

Build the image:

```bash
docker build -f app/Dockerfile -t devops-intern-final:local app/
```

Run the container:

```bash
docker run -d --name devops-nginx -p 8080:8080 devops-intern-final:local
```

Test the application:

```bash
curl http://localhost:8080/
curl http://localhost:8080/healthz
curl http://localhost:8080/build-info
```

The `/healthz` endpoint returned a successful HTTP response during my local testing.

## 3. GitHub Actions

I configured a GitHub Actions workflow in `.github/workflows/ci.yml`.

The workflow includes shell script checking, Dockerfile linting, Docker image building, and application health testing. It is also configured to publish images to GitHub Container Registry (GHCR).

Workflow results can be checked here:

[View GitHub Actions](https://github.com/Shivamagarwal0404/devops-intern-final/actions)

## 4. Nomad and Consul

I created a Nomad job file at `nomad/nginx-app.nomad.hcl` to run the NGINX container.

Validate the job:

```bash
nomad job validate nomad/nginx-app.nomad.hcl
```

Run the job:

```bash
nomad job run nomad/nginx-app.nomad.hcl
```

Check the job status:

```bash
nomad job status nginx-app
nomad job allocs nginx-app
```

I validated the job and ran it in my local development environment. The configuration includes an HTTP health check for `/healthz`, along with restart and rescheduling settings.

## 5. Monitoring

I used Docker Compose to run Grafana, Loki, and Promtail.

Start the monitoring services:

```bash
cd monitoring
docker compose up -d
```

Check the services:

```bash
docker compose ps
```

Open Grafana in your browser:

http://localhost:3000

I configured Loki as a Grafana data source and used Grafana Explore to search application logs.

Example LogQL query:

```logql
{job="docker-containers", container="devops-nginx"}
```

I also queried Loki directly and confirmed that NGINX access logs were available, including requests that returned HTTP status `200`.

### Screenshot

The screenshot from Grafana Explore is saved here:

[`docs/screenshots/grafana-explore.png`](docs/screenshots/grafana-explore.png)

## What I Learned

While working on this project, I practised:

- Writing and running Bash scripts in Linux.
- Building and testing Docker images.
- Configuring NGINX and HTTP health checks.
- Creating a CI workflow with GitHub Actions.
- Writing and validating a Nomad job.
- Using Consul for service registration and health checks.
- Collecting and searching container logs using Promtail and Loki.
- Viewing logs through Grafana Explore.

## Repository

GitHub: https://github.com/Shivamagarwal0404/devops-intern-final

