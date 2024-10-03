FROM matrixdotorg/synapse:v1.116.0
COPY downstream_start.sh /downstream_start.sh
ENTRYPOINT /downstream_start.sh
