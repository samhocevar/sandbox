# Slackdump reencode

This quick and dirty bash script crawls the `__uploads` directory from a [slackdump](https://github.com/rusq/slackdump)
archive and reencodes videos using [FFmpeg](https://www.ffmpeg.org/) with high quality settings.

I have used the script on multiple Slack instances, and I have experienced a 40 to 50% storage space gain,
with no visually noticeable differences in the files. YMMV, of course.

Usage:

    slackdump-reencode.sh [DIRECTORY]

**Warning**: this script does not backup the video files if the reencoding is successful _and_ the
new file is significantly smaller than the old file. Make your own backups, or rely on `slackdump archive`
to redownload files you wish to restore.

I consider this script to be too trivial to qualify for copyright, but if you want to distribute it
under the terms of a software licence, please use the [WTFPL](https://www.wtfpl.net/).
