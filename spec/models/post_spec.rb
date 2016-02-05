require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe "validations" do
    it "validates the presence of a post's title" do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "validates the minimum length of a Post's title" do
      p = Post.new(title: "abcdef")
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "validates the presence of a post's body" do
        p = Post.new
        p.valid?
        expect(p.errors).to have_key(:body)
    end

  end
end
