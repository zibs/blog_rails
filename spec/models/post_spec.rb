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

    it "formats #body_snippets if body > 100 characters " do
      p = Post.new(title: "abcedfghijk", body: "a" * 110)

      expect(p.body_snippet).to include("...")
    end

    it "does not format #body_snippets if body < 100 characters " do
      p = Post.new(title: "abcedfghijk", body: "a" * 99)

      expect(p.body_snippet).to_not include("...")
    end
 # Test drive a method `body_snippet` method that returns a maximum of a 100 characters with "..." of the body if it's more than a 100 characters long.

  end
end
