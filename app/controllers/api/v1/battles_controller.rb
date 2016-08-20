module Api
  module V1
    class BattlesController < Api::V1::BaseController
      # before_action :doorkeeper_authorize!
      before_action :find_battle, only: [:show, :update, :destroy]
      before_action :update_params, only: [:update]

      def index
        battles = current_user.try(:battles) || Battle.all
        filtered_battles = apply_filters(battles, params[:filter])

        render json: filtered_battles.order("created_at DESC")
      end

      def show
        render json: @battle
      end

      def update
        @battle.update(battle_params)

        if @battle.valid?
          render json: @battle
        else
          render json: ErrorSerializer.serialize(@battle.errors), status: :unprocessable_entity
        end
      end

      def create
        battle = current_user.battles.create(battle_params)
        battle.update_attributes(challenger_email: current_user.email)

        if battle.valid?
          render json: battle, status: :created
        else
          render json: ErrorSerializer.serialize(battle.errors), status: :unprocessable_entity
        end
      end

      def destroy
        @battle.destroy!
        render json: @battle
      end

      private
      def apply_filters(battles, filter)        
        if filter.try!(:[], :range)          
          Battle.all
        else
          battles
        end
      end

      def find_battle
        @battle = current_user.battles.find(params[:id])
      end

      def update_params
        if params[:data][:attributes]      
          params[:data][:attributes][:challenger_pet_id] = current_user.pets.find_by_name(params[:data][:attributes][:challenger_pet_id]).try(:id) if params[:data][:attributes][:challenger_pet_id].to_i == 0
          params[:data][:attributes][:challenged_pet_id] = current_user.pets.find_by_name(params[:data][:attributes][:challenged_pet_id]).try(:id) if params[:data][:attributes][:challenged_pet_id].to_i == 0
        end
      end

      def battle_params
        params.require(:data).require(:attributes).permit(:winner_id, :loser_id, :name, :challenged_email, :challenger_email, :challenger_pet_id, :challenged_pet_id)
      end
    end
  end
end
