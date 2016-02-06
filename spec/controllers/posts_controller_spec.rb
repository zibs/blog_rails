require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  before(:each) do
    Post.delete_all
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new Post object" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "#create" do
    context "with_valid_attributes" do

      def valid_post_request
        post :create, post: { title: "On the Nature of Things", body: "Lucretius is a serious naturalist boss." }
      end

      it "creates a record in the database" do
        db_post_count = Post.count
        valid_post_request
        expect {valid_post_request}.to change{Post.count}.by(1)
      end

      it "redirects to the `show` upon post" do
        valid_post_request
        expect(response).to redirect_to(posts_path(Post.last))
      end

      it "sets a flash notice upon successful create" do
        valid_post_request
        expect(flash[:notice]).to be
      end

    end

    context "with invalid attributes" do
      def invalid_post_request
        post :create, post: { title: "", body: ""}
      end

      it "doesn't create a record in the database" do
        expect {invalid_post_request}.not_to change{Post.count}
      end
      it "renders to new upon unsuccessful post" do
        invalid_post_request
        expect(response).to render_template(:new)
      end

      it "should set a flash alert upon invalid attributes" do
        invalid_post_request
        expect(flash[:alert]).to be
      end

    end
  end

  describe "#edit" do
    it "renders the edit template" do
      Post.create(title: "akjsdkjasdnjka", body: "asjkdnakjsdn")
      get :edit, id: Post.last
      # p Post.last
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    let(:post){ Post.create!(title: "aabcdefgh", body: "ladeedaa") }

      def update_post
        patch :update, id: post, post: { title: "zxywqtrsc", body: "ladeedaa"}
      end

    it "updates the attributes with" do
      expect { update_post }.to change{ post.reload.title }.from("Aabcdefgh").to("zxywqtrsc")
    end

    it "redirects to user patch after successful update" do
      update_post
      expect(response).to redirect_to(post_path(post))
    end
  end

  describe "#destroy" do

    let!(:post){FactoryGirl.create(:post)}

      def delete_post
        delete :destroy, id: post
      end

      it "removes the record from the database" do
        expect{delete :destroy, id: post}.to change{Post.count}.by(-1)
      end

      it "redirects to the index template" do
        delete_post
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message upon deletion" do
        delete_post
        expect(flash[:alert]).to be
      end

  end
    # if @post.update(post_params)
    #   redirect_to post_path(@post)
    # else
    #   render :edit
    # end

end
