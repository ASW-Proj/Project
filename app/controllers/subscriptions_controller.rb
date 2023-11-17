class SubscriptionsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]

    def create
        @subscription = Subscription.new(community: community, user: current_user)
        
        respond_to do |format|
            if @subscription.save
                format.html { redirect_to communities_path, notice: "You have subscribed succesfully to the community." }
            else
                format.html { redirect_to communities_path, notice: "You are already subscribed to the community." }
            end
        end
    end

    def destroy
        community.subscriptions.find_by(user: current_user).destroy!      
        respond_to do |format|
            format.html { redirect_to communities_path, notice: "You have unsubscribed succesfully from the community." }
        end
    end

    private

    def community
        @community ||= Community.find(params[:community_id])
    end
end