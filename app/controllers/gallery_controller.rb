# frozen_string_literal: true

class GalleryController < ApplicationController
  def index
    client = DropboxApi::Client.new("")

    result = client.list_folder("/Camera Uploads", include_media_info: true)

    paths = result.entries.map(&:path_lower)

    @results = client.get_thumbnail_batch(
      paths.take(10),
      size: :w640h480,
      mode: :strict
    ).entries

    @more = result.has_more?
  end
end
