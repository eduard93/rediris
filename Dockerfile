FROM intersystems/iris:2021.1.1.324.0

ENV ISC_CPF_MERGE_FILE=/tmp/merge.cpf
ENV PIP_NO_CACHE_DIR=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1

USER root

RUN apt-get update && apt-get install -y curl

USER ${ISC_PACKAGE_MGRUSER}

RUN curl https://bootstrap.pypa.io/pip/3.6/get-pip.py | python3 - 
RUN python3 -m pip install lupa /usr/irissys/dev/python/intersystems_irispython-3.2.0-py3-none-any.whl

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP irissession.sh /
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP rediris /tmp/rediris/rediris
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP setup.py /tmp/rediris
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP setup.cfg /tmp/rediris
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP merge.cpf /tmp/merge.cpf

RUN cd /tmp/rediris && python3 setup.py install --install-purelib=$ISC_PACKAGE_INSTALLDIR/mgr/python

RUN chmod +x /irissession.sh

SHELL ["/irissession.sh"]

RUN \
  zn "%SYS" \
  do $SYSTEM.OBJ.LoadDir("/tmp/iris", "ck", , 1)

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]