FROM solr:6.4
MAINTAINER  Jason Dudash "jason.dudash@gmail.com"

USER root
ENV STI_SCRIPTS_PATH=/usr/libexec/s2i

LABEL io.k8s.description="Run SOLR search in OpenShift" \
      io.k8s.display-name="SOLR 6.4" \
      io.openshift.expose-services="8983:http" \
      io.openshift.tags="builder,solr,solr6.4" \
      io.openshift.s2i.scripts-url="image:///${STI_SCRIPTS_PATH}" \

# Give the SOLR directory to root group (not root user)
# https://docs.openshift.org/latest/creating_images/guidelines.html#openshift-origin-specific-guidelines
RUN chgrp -R 0 /opt/solr \
  && chmod -R g+rwX /opt/solr

USER 8983
