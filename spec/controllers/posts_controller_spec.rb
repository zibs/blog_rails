require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  # before many actions in Post, we will need to sign in.
  # let(:blogpost){create(:post)}
  let(:user){create(:user)}

  context "authenticated user" do
      before { log_in(user) }

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
        context "with valid parameters" do

          let(:post_attributes){attributes_for(:post)}

          def send_valid_request
            post :create, { post: post_attributes }
          end

          it "creates a post record in the database" do
            expect{send_valid_request}.to change{Post.count}.by(1)
          end

          it "associates the post with a user" do
            send_valid_request
            # expect(Post.last.user_id).to eq(user.id)
            expect(Post.last.user_id).to eq(user.id)
          end

          it "sets a flash message" do
            send_valid_request
            expect(flash[:info]).to be
          end

          it "redirects to the posts show" do
            send_valid_request
            expect(response).to redirect_to(posts_path(Post.last))
          end
        end

        context "with invalid parameters" do

          def send_invalid_request
            post :create, post: attributes_for(:post, {title: nil} )
          end

          it "doesn't create a record in the database" do
            expect{send_invalid_request}.to_not change{Post.count}
          end
          it "renders the new template" do
            send_invalid_request
            expect(response).to render_template(:new)
          end
          it "sets a flash message" do
            send_invalid_request
            expect(flash[:warning]).to be
          end

        end
      end

      describe "#edit" do
        context "with valid attributes" do
          # this is not hitting the controller so its not making the association

          let(:post_attributes){attributes_for(:post)}

          before do
            @blogpost = user.posts.create(post_attributes)
          end

          it "renders edit" do
            get :edit, id: @blogpost
            expect(response).to render_template(:edit)
          end
        end
      end

      describe "#update" do
        context "with valid attributes" do
          # let(:blog_post){create(:post, user_id: user.id)}

          def update_blogpost
            @blogpost = user.posts.create(title: "abcdefghijk", body: "123123123123")
            patch :update, id: @blogpost, post: { title: "123123123"}
          end

          it "updates the attributes with the parameters" do

            update_blogpost
            expect(@blogpost.reload.title).to eq("123123123")
            #expect(@).to change {@blogpost.reload.title}.from("Abcdefghijk").to("123123123")
          end

          it "redirects to user page after successful update" do
            update_blogpost
            expect(response).to redirect_to(post_path(@blogpost))
          end
        end

        context "without valid attributes" do

          def update_invalid_blogpost
            @blogpost = user.posts.create(title: "abcdefghijk", body: "123123123123")
            patch :update, id: @blogpost, post: { title: ""}
          end

          it "doesn't update the record in the database" do
            update_invalid_blogpost
            expect(@blogpost.reload.title).to eq(@blogpost.title)
          end

          it "renders the edit template" do
            update_invalid_blogpost
            expect(response).to render_template(:edit)
          end
        end
      end

      describe "#destroy" do

        let!(:firstblogpost){create(:post, user_id: user.id)}
        let!(:blogpost){create(:post, user_id: user.id)}

        def delete_post
          delete :destroy, id: blogpost
         end

         it "removes the record from the database" do
           expect{delete_post}.to change{Post.count}.by(-1)
         end

         it "redirects to the index template" do
           delete_post
           expect(response).to redirect_to(root_path)
         end

         it "sets a flash message upon deletion" do
           delete_post
           expect(flash[:warning]).to be
         end
       end
    end
end



        #   describe "#update" do
        #     let(:post){ Post.create!(title: "aabcdefgh", body: "ladeedaa") }
        #
        #       def update_post
        #         patch :update, id: post, post: { title: "zxywqtrsc", body: "ladeedaa"}
        #       end
        # it "updates the attributes with" do
       #       expect { update_post }.to change{ post.reload.title }.from("Aabcdefgh").to("zxywqtrsc")
       #     end
       #
       #     it "redirects to user patch after successful update" do
       #       update_post
       #       expect(response).to redirect_to(post_path(post))
       #     end
       #   end



#   # before(:each) do
#     # Post.delete_all
#   # end
#
# # context "logged in as a User" do
# #   before do
# #
# #   end
# # end
#
#     describe "#new" do
#       it "renders the new template" do
#         get :new
#         expect(response).to render_template(:new)
#       end
#
#       it "instantiates a new Post object" do
#         get :new
#         expect(assigns(:post)).to be_a_new(Post)
#       end
#     end
#
#     describe "#create" do
#       context "with_valid_attributes" do
#
#         def valid_post_request
#           post :create, post: { title: "On the Nature of Things", body: "Lucretius is a serious naturalist boss." }
#         end
#
#         it "creates a record in the database" do
#           db_post_count = Post.count
#           valid_post_request
#           expect {valid_post_request}.to change{Post.count}.by(1)
#         end
#
#         it "redirects to the `show` upon post" do
#           valid_post_request
#           expect(response).to redirect_to(posts_path(Post.last))
#         end
#
#         it "sets a flash notice upon successful create" do
#           valid_post_request
#           expect(flash[:notice]).to be
#         end
#
#       end
#
#       context "with invalid attributes" do
#         def invalid_post_request
#           post :create, post: { title: "", body: ""}
#         end
#
#         it "doesn't create a record in the database" do
#           expect {invalid_post_request}.not_to change{Post.count}
#         end
#         it "renders to new upon unsuccessful post" do
#           invalid_post_request
#           expect(response).to render_template(:new)
#         end
#
#         it "should set a flash alert upon invalid attributes" do
#           invalid_post_request
#           expect(flash[:alert]).to be
#         end
#
#       end
#     end
#   end
#
#   describe "#edit" do
#     it "renders the edit template" do
#       Post.create(title: "akjsdkjasdnjka", body: "asjkdnakjsdn")
#       get :edit, id: Post.last
#       # p Post.last
#       expect(response).to render_template(:edit)
#     end
#   end
#
#   describe "#update" do
#     let(:post){ Post.create!(title: "aabcdefgh", body: "ladeedaa") }
#
#       def update_post
#         patch :update, id: post, post: { title: "zxywqtrsc", body: "ladeedaa"}
#       end
#
#     it "updates the attributes with" do
#       expect { update_post }.to change{ post.reload.title }.from("Aabcdefgh").to("zxywqtrsc")
#     end
#
#     it "redirects to user patch after successful update" do
#       update_post
#       expect(response).to redirect_to(post_path(post))
#     end
#   end
#
#   describe "#destroy" do
#
#     let!(:post){FactoryGirl.create(:post)}
#
#       def delete_post
#         delete :destroy, id: post
#       end
#
#       it "removes the record from the database" do
#         expect{delete :destroy, id: post}.to change{Post.count}.by(-1)
#       end
#
#       it "redirects to the index template" do
#         delete_post
#         expect(response).to redirect_to(root_path)
#       end
#
#       it "sets a flash message upon deletion" do
#         delete_post
#         expect(flash[:alert]).to be
#       end
#
#   end
