#!/bin/sh -l
set -eu
export PATH=$PATH:/go/bin


##
##
webhook_branch () {
  HEAD_SRC=$(jq -r '.pull_request.head.repo.full_name' < ${GITHUB_EVENT_PATH})
  HEAD_REF=$(jq -r '.pull_request.head.ref' < ${GITHUB_EVENT_PATH})
  HEAD_SHA=$(jq -r '.pull_request.head.sha' < ${GITHUB_EVENT_PATH})

  BASE_SRC=$(jq -r '.pull_request.base.repo.full_name' < ${GITHUB_EVENT_PATH})
  BASE_REF=$(jq -r '.pull_request.base.ref' < ${GITHUB_EVENT_PATH})
  BASE_SHA=$(jq -r '.pull_request.base.sha' < ${GITHUB_EVENT_PATH})

  NUMBER=$(jq -r '.number' < ${GITHUB_EVENT_PATH})
  TITLE=$(jq -r '.pull_request.title' < ${GITHUB_EVENT_PATH})

  echo "==> base: ${BASE_SRC}/${BASE_REF}/${BASE_SHA}"
  echo "==> head: ${HEAD_SRC}/${HEAD_REF}/${HEAD_SHA}"

  opts=${INPUT_TARGET:+--url $INPUT_TARGET}

  assay \
    webhook branch \
    --api ${INPUT_API} \
    --key ${INPUT_SECRET} \
    --head ${HEAD_SRC}/${HEAD_REF}/${HEAD_SHA} \
    --base ${BASE_SRC}/${BASE_REF}/${BASE_SHA} \
    --number ${NUMBER} \
    --title "${TITLE}" \
    $opts
}

##
##
webhook_commit () {
  cat ${GITHUB_EVENT_PATH}
}


case "${GITHUB_EVENT_NAME}" in
  "pull_request")
    webhook_branch
    ;;
  "push")
    webhook_commit
    ;;
  *)
    echo "Event ${GITHUB_EVENT_NAME} is not supported by the action"
    exit 128
esac

