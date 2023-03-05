all: publish

app:
	echo "Building app"
	test -d /tmp/gradlecache || mkdir /tmp/gradlecache
	podman run -it --memory 2g -v $(shell pwd):/project -v /tmp/gradlecache:"/root/.gradle" mingc/android-build-box bash -c 'cd /project; ./gradlew :addons:languages:russian2:apk:assembleDebug'

publish: app
	rm -fr /var/lib/fdroid/unsigned/*
	mv outputs/apks/debug/addons-languages-russian2-apk-1.apk /var/lib/fdroid/unsigned/com.anysoftkeyboard.languagepack.russian2_$(date '+%s').apk
	touch /var/lib/fdroid/metadata/com.anysoftkeyboard.languagepack.russian2.yml
	cd /var/lib/fdroid && fdroid publish --verbose && fdroid update --verbose
