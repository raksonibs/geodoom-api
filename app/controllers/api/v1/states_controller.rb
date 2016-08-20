module Api
  module V1
    class StatesController < Api::V1::BaseController
      # before_action :doorkeeper_authorize!
      before_action :find_state, only: [:show, :update, :destroy]

      def index
        states = State.all

        # filtered_states = apply_filters(states, params[:filter])

        render json: states.order("created_at DESC")
      end

      def show
        
        if @state 
        else
          @state = State.find_by_id(params[:id])
        end

        render json: @state
      end

      def update
        @state.update(state_params)

        if @state.valid?
          render json: @state
        else
          render json: ErrorSerializer.serialize(@state.errors), status: :unprocessable_entity
        end
      end

      def create
        stat = State.create(state_params)

        if stat.valid?
          render json: stat, status: :created
        else
          render json: ErrorSerializer.serialize(stat.errors), status: :unprocessable_entity
        end
      end

      def destroy
        @state.destroy!
        render json: @state
      end

      private
      def apply_filters(states, filter)        
        if filter.try!(:[], :period)          
          states
        else
          states
        end
      end

      def find_state
        @state = Stat.find_by_id(params[:id])
      end

      def state_params
        params.require(:data).require(:attributes).permit(:winner_id, :loser_id)
      end
    end
  end
end
