all: publish

app:
	echo "Building app"
	test -d /tmp/gradlecache || mkdir /tmp/gradlecache
	podman run -it --memory 2g -v $(shell pwd):/project -v /tmp/gradlecache:"/root/.gradle" mingc/android-build-box bash -c 'cd /project; ./gradlew :addons:languages:russian2:apk:assembleDebug'

publish: app
	rm -fr /var/lib/fdroid/unsigned/*
	tree
