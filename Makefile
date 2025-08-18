# Variables
IMAGE_NAME = mail-sender
CONTAINER_NAME = my-mail-sender

# Targets
.PHONY: all build run stop rm rmi clean send-test-mail debug-ssmtp

all: build run

build:
	@echo "Building Docker image $(IMAGE_NAME)..."
	docker build -t $(IMAGE_NAME) .

run:
	@echo "Running Docker container $(CONTAINER_NAME)..."
	docker run -d --name $(CONTAINER_NAME) -v "$(PWD)/ssmtp.conf:/etc/ssmtp/ssmtp.conf:ro" $(IMAGE_NAME)

stop:
	@echo "Stopping Docker container $(CONTAINER_NAME)..."
	docker stop $(CONTAINER_NAME)

rm:
	@echo "Removing Docker container $(CONTAINER_NAME)..."
	docker rm $(CONTAINER_NAME)

rmi:
	@echo "Removing Docker image $(IMAGE_NAME)..."
	docker rmi $(IMAGE_NAME)

clean: stop rm rmi
	@echo "Cleaned up Docker container and image."

send-test-mail:
	@echo "Sending test email..."
	echo "Este es el cuerpo del correo de prueba desde Docker." | docker exec -i $(CONTAINER_NAME) mail -s "Prueba de MailUtils (Makefile)" elswork@gmail.com

debug-ssmtp:
	@echo "Debugging SSMTP connection..."
	echo -e "To: elswork@gmail.com\nFrom: elswork@gmail.com\nSubject: Debug SSMTP\n\nThis is a debug message." | docker exec -i $(CONTAINER_NAME) ssmtp -v elswork@gmail.com
