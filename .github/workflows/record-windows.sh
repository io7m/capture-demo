exec > >(tee build.txt) 2>&1

#---------------------------------------------------------------------
# Start recording the session.
#

ffmpeg \
  -f x11grab \
  -y \
  -r 60 \
  -video_size 1280x1024 \
  -i :99 \
  video.webm &

FFMPEG_PID="$!"
sleep 1

#------------------------------------------------------------------------
# Play some video.

wget https://ataxia.io7m.com/2023/05/25/flowers.webm
ffplay -autoexit flowers.webm

#---------------------------------------------------------------------
# Wait a while, and then instruct ffmpeg to stop recording. This step
# is necessary because video files need to be processed when recording
# stops.
#

sleep 20
kill -INT "${FFMPEG_PID}"

