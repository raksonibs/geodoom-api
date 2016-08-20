module Api
  module V1
    class PetStatesController < Api::V1::BaseController
      # before_action :doorkeeper_authorize!
      before_action :find_pet_state, only: [:show, :update, :destroy]

      def index
        states = PetState.all

        filtered_states = apply_filters(states, params[:filter])

        render json: filtered_states.order("created_at DESC")
      end

      def show      
        if @pet_state 
        else
          @pet_state = PetState.find_by_id(params[:id])
        end

        render json: @pet_state
      end

      def update
        @pet_state.update(stat_params)

        if @pet_state.valid?
          render json: @pet_state
        else
          render json: ErrorSerializer.serialize(@pet_state.errors), status: :unprocessable_entity
        end
      end

      def create
        stat = PetState.create(stat_params)

        if stat.valid?
          render json: stat, status: :created
        else
          render json: ErrorSerializer.serialize(stat.errors), status: :unprocessable_entity
        end
      end

      def destroy
        @pet_state.destroy!
        render json: @pet_state
      end

      private
      def apply_filters(states, filter)        
        if filter.try!(:[], :battle_id)          
          State.find_by_battle_id(filter[:battle_id]).pet_states
        else
          states
        end
      end

      def find_pet_state
        @pet_state = PetState.find_by_id(params[:id])
      end

      def stat_params
        params.require(:data).require(:attributes).permit(PetState.columns.map(&:to_sym))
      end
    end
  end
end
