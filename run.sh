#!/bin/sh -l
# set -eu
export PATH=$PATH:/go/bin:/usr/local/go/bin

cd $GITHUB_WORKSPACE
[[ ! -z $INPUT_WORKING_DIRECTORY ]] && cd $INPUT_WORKING_DIRECTORY

assay-it test

##
## common opts
# opts=${INPUT_TARGET:+--url $INPUT_TARGET}

# ##
# ##
# webhook_pull_request () {
#   HEAD_SRC=$(jq -r '.pull_request.head.repo.full_name' < ${GITHUB_EVENT_PATH})
#   HEAD_REF=$(jq -r '.pull_request.head.ref' < ${GITHUB_EVENT_PATH})
#   HEAD_SHA=$(jq -r '.pull_request.head.sha' < ${GITHUB_EVENT_PATH})

#   BASE_SRC=$(jq -r '.pull_request.base.repo.full_name' < ${GITHUB_EVENT_PATH})
#   BASE_REF=$(jq -r '.pull_request.base.ref' < ${GITHUB_EVENT_PATH})
#   BASE_SHA=$(jq -r '.pull_request.base.sha' < ${GITHUB_EVENT_PATH})

#   NUMBER=$(jq -r '.number' < ${GITHUB_EVENT_PATH})
#   TITLE=$(jq -r '.pull_request.title' < ${GITHUB_EVENT_PATH})

#   echo "==> base: ${BASE_SRC}/${BASE_REF}/${BASE_SHA}"
#   echo "==> head: ${HEAD_SRC}/${HEAD_REF}/${HEAD_SHA}"

#   assay \
#     webhook \
#     --api ${INPUT_API} \
#     --key ${INPUT_SECRET} \
#     --head ${HEAD_SRC}/${HEAD_REF}/${HEAD_SHA} \
#     --base ${BASE_SRC}/${BASE_REF}/${BASE_SHA} \
#     --number ${NUMBER} \
#     --title "${TITLE}" \
#     $opts
# }

# ##
# ##
# webhook_push () {
#   SRC=$(jq -r '.repository.full_name' < ${GITHUB_EVENT_PATH})
#   REF=$(basename $(jq -r '.ref' < ${GITHUB_EVENT_PATH}))
#   SHA=$(jq -r '.after' < ${GITHUB_EVENT_PATH})

#   NUMBER=$(echo $(jq -r '.head_commit.id' < ${GITHUB_EVENT_PATH}) | cut -c1-7)
#   TITLE=$(jq -r '.head_commit.message' < ${GITHUB_EVENT_PATH})

#   echo "==> commit: ${SRC}/${REF}/${SHA}"

#   assay \
#     webhook commit \
#     --api ${INPUT_API} \
#     --key ${INPUT_SECRET} \
#     --number ${NUMBER} \
#     --title "${TITLE}" \
#     $opts ${SRC}/${REF}/${SHA}
# }

# ##
# ##
# webhook_release () {
#   SRC=$(jq -r '.repository.full_name' < ${GITHUB_EVENT_PATH})
#   REF=$(jq -r '.release.target_commitish' < ${GITHUB_EVENT_PATH})
#   SHA=$(jq -r '.release.tag_name' < ${GITHUB_EVENT_PATH})

#   echo "==> commit: ${SRC}/${REF}/${SHA}"

#   assay \
#     webhook release \
#     --api ${INPUT_API} \
#     --key ${INPUT_SECRET} \
#     --number ${SHA} \
#     --title "release ${SHA}" \
#     $opts ${SRC}/${REF}/${SHA}
# }


# case "${GITHUB_EVENT_NAME}" in
#   "pull_request")
#     webhook_pull_request
#     ;;
#   "push")
#     webhook_push
#     ;;
#   "release")
#     webhook_release
#     ;;
#   *)
#     echo "Event ${GITHUB_EVENT_NAME} is not supported by the action"
#     exit 128
# esac
