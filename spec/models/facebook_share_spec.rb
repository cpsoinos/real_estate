describe FacebookShare do

  let(:facebook_share) { create(:facebook_share) }

  it "validates the presence of a facebook page" do
    expect(facebook_share.facebook_page).not_to eq(nil)
  end

end

describe FacebookShare, "#share" do

  let(:user) { create_from_omniauth }
  # let(:facebook_share) { create(:facebook_share) }

  it "shares to a Facebook page" do
    facebook_share = user.facebook_pages.first.facebook_shares.new(content: "this is a test")
  # expect(Object.method :is_a?).to be_delayed(Object)
    facebook_share.share
    binding.pry
    expect(FacebookShareJob).to have(1).enqueued.job
    # expect(facebook_share.share).to be_delayed(FacebookShareJob)
    # expect(facebook_share.share).to change(FacebookShareJob.jobs, :size).by(1)
  end
end

describe FacebookShare, "#delete_share" do
  it "deletes a share from Facebook" do
    pending("testing with apis")
    facebook_share = create(:facebook_share)

    expect(facebook_share.delete_share.response).to eq("success")
  end
end

describe FacebookShare, "#get_share_type" do

  context "link" do
    it "adds 'link' to share_type for link share" do
      facebook_share = create(:facebook_share, :link)
      facebook_share.get_share_type

      expect(facebook_share.share_type).to eq("link")
    end
  end

  context "text" do
    it "adds 'text' to share_type for text share" do
      facebook_share = create(:facebook_share)
      facebook_share.get_share_type

      expect(facebook_share.share_type).to eq("text")
    end
  end
end

describe FacebookShare, "#get_share_url" do
  it "gets the Facebook url of a share" do
    pending("figuring out how to get the url of a share")
    facebook_share = create(:facebook_share)
    facebook_share.get_share_url

    expect(facebook_share.url).not_to eq(nil)
  end
end
