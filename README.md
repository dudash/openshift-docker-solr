# Containerized SOLR + OpenShift
Apache SOLR makes it easy to add search capability into your Java apps.  SOLR is a search server (backed by the Lucene serach library).  This repository provides a way for you to take advantage of that in OpenShift.

<h1> THIS IS CURRENTLY IN WORK ---- YMMV</h1>

<h3>There are 2 distinct parts to this repo:</h3>
    
*(1) A Dockerfile*

This overrides the [official SOLR image][2] to tweak a few things in order to run SOLR efficiently on OpenShift.  
<h4>FYI, you don't have to build the image, you can use a prebuilt image - I'll try to keep updated versions of it available on docker hub.</h4>

[![docker hub stats](http://dockeri.co/image/dudash/openshift-solr)](https://hub.docker.com/r/dudash/openshift-solr/)


*(2) S2I scripts (comging soon)*

These are to allow you to easily push your project specific configuration files in to SOLR.


## How to use all of this with your apps
Sounds cool right?  It is.  And here's how you can use it.

### If you just want to try running SOLR in OpenShift...

Create the SOLR app from a Docker image
`> oc new-app dudash/openshift-solr --name=solr-imageonly-demo`

Now you can access it via the route that was automatically exposed on port 8983 and whereever your OpenShift apps route (e.g. openshift-solr-myproject.127.0.0.1.nip.io).  Note: this won't autogenerate a SOLR core.


### If you want to provide configuration in an automated way...
* Create a repo
* Create a folder called `conf` and add SOLT config files for your desired SOLR configuration
  (See [here for an example](https://github.com/dudash/openshiftexamples-solrdemo)).

* Create a new app using oc CLI (this will also create the SOLR core and inject your configuration).  Note: if your 'conf' dir isn't at the root of your repo, you'll need to append '--context-dir=PATH'
`> oc new-app dudash/openshift-solr~https://github.com/[YOU]/[YOUR-REPO].git --name=solr-demo`


Now you can access it via the route that was automatically exposed on port 8983 and whereever your OpenShift apps route (e.g. openshift-solr-myproject.127.0.0.1.nip.io).  And a SOLR core is automatically created for use.

* (optionally) You can import the image stream to make this available in the webconsole of OpenShift
`> TBD need to write the image stream template`

### Cluster considerations
TBD node selectors to make sure SOLR goes to a node w/ enough memory
TBD using with persistent storage

## About this repo
Here is some information about how this all works behind the scenes.

### The Dockerfile

### The S2I process
This repo doesn't require [the s2i tool](https://github.com/openshift/source-to-image) to build the image.  However, if you look into the Dockerfile, it does set some s2i LABELS in order for OpenShift to be able to use it as an s2i builder image.

#### assemble script details
TBD

#### run script details
TBD


## Want to help?
If you find and issues, go ahead and write them up.  If you want to submit some code changes, please see the [CONTRIBUTING][3] docs.


[1]: https://github.com/docker-solr/docker-solr
[2]: https://store.docker.com/images/f4e3929d-d8bc-491e-860c-310d3f40fff2?tab=description
[3]: ./CONTRIBUTING.md
