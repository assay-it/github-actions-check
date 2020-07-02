#!/bin/sh -l

if [ "${GITHUB_EVENT_NAME}" != "pull_request" ] ;
then
  echo "Event ${GITHUB_EVENT_NAME} is not supported"
  exit 128
fi

HEAD_SRC=$(/go/bin/jq '.pull_request.head.repo.full_name' < ${GITHUB_EVENT_PATH})
HEAD_REF=$(/go/bin/jq '.pull_request.head.ref' < ${GITHUB_EVENT_PATH})
HEAD_SHA=$(/go/bin/jq '.pull_request.head.sha' < ${GITHUB_EVENT_PATH})

BASE_SRC=$(/go/bin/jq '.pull_request.head.repo.full_name' < ${GITHUB_EVENT_PATH})
BASE_REF=$(/go/bin/jq '.pull_request.head.ref' < ${GITHUB_EVENT_PATH})
BASE_SHA=$(/go/bin/jq '.pull_request.head.sha' < ${GITHUB_EVENT_PATH})

NUMBER=$(/go/bin/jq '.number' < ${GITHUB_EVENT_PATH})
TITLE=$(/go/bin/jq '.pull_request.title' < ${GITHUB_EVENT_PATH})


/go/bin/assay \
  -api latest.assay.it \
  -secret $1 \
  -head ${HEAD_SRC}/${HEAD_REF}/${HEAD_SHA} \
  -base ${BASE_SRC}/${BASE_REF}/${BASE_SHA} \
  -number ${NUMBER} \
  -title ${TITLE}
