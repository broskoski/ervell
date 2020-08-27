import gql from 'graphql-tag'

export default gql`
  fragment KonnectableAttachment on Attachment {
    id
    title
    href
    src: image_url(size: DISPLAY)
    # scale up the non-retina src to avoid blurry text
    src_1x: resized_image_url(width: 415, height: 415, quality: 90)
    src_2x: resized_image_url(width: 630, height: 630)
    src_3x: resized_image_url(width: 945, height: 945)
    file_extension
  }
`
