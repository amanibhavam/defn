FROM defn/dev

RUN touch /tmp/meh1
RUN touch /tmp/meh2
RUN touch /tmp/meh3

ENTRYPOINT ["bash", "-c", "set -x; uname -a; date; sleep 86400"]
