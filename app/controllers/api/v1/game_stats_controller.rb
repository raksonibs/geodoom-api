module Api
  module V1
    class GameStatsController < Api::V1::BaseController
      # before_action :doorkeeper_authorize!
      before_action :find_stat, only: [:show, :update, :destroy]

      def index
        stats = current_user.game_stats

        # filtered_stats = apply_filters(stats, params[:filter])

        render json: stats.order("created_at DESC")
      end

      def show
        
        if @stat 
        else
          @stat = current_user.game_stats.find_by_id(params[:id])
        end

        render json: @stat
      end

      def update
        @stat.update(stat_params)

        if @stat.valid?
          render json: @stat
        else
          render json: ErrorSerializer.serialize(@stat.errors), status: :unprocessable_entity
        end
      end

      def create
        stat = current_user.game_stats.create(stat_params)

        if stat.valid?
          render json: stat, status: :created
        else
          render json: ErrorSerializer.serialize(stat.errors), status: :unprocessable_entity
        end
      end

      def destroy
        @stat.destroy!
        render json: @stat
      end

      private
      def apply_filters(stats, filter)        
        if filter.try!(:[], :period)          
          stats
        else
          stats
        end
      end

      def find_stat
        @stat = GameStat.find_by_id(params[:id])
      end

      def stat_params
        params.require(:data).require(:attributes).permit(:id, :user, :name, :value)
      end
    end
  end
end
