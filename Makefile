all: clean build test

clean:
	bundle exec jekyll clean

build:
	bundle exec jekyll build

test: build
	bundle exec htmlproofer ./_site

serve:
	bundle exec jekyll serve
