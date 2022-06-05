build:
	docker build . -t blockchain -f _production.dockerfile\
	&& docker run -it blockchain

