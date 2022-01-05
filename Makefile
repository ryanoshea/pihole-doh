rebuild:
	docker compose down --remove-orphans && \
	docker compose build && \
	docker compose up -d && \
	docker compose logs -f

stop:
	docker compose down --remove-orphans && \
	docker image prune -f
