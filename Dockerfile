FROM codesimple/elm:0.16

COPY examples /code
WORKDIR /code
RUN mkdir elm-stuff