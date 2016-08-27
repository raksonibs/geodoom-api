module Api
  module V1
    class PetsController < Api::V1::BaseController
      # before_action :doorkeeper_authorize!
      before_action :find_pet, only: [:show, :update, :destroy]

      def index
        if params[:page]
          pets = if current_user
            Pet.page(params[:page]).per(params[:per_page]).where(user: current_user)
          else
            Pet.all
          end          
        else
          pets = if current_user
            Pet.page(params[:page]).per(params[:per_page]).where(user: current_user)
          else
            Pet.all
          end
          pets =  current_user.try(:pets) || Pet.all
        end        

        render json: pets.order("created_at DESC")
      end

      def show
        render json: @pet
      end

      def update
        @pet.update(pets_params)

        if @pet.valid?
          render json: @pets
        else
          render json: ErrorSerializer.serialize(@pets.errors), status: :unprocessable_entity
        end
      end

      def create
        pet = current_user.pets.create(pets_params)
        
        if pet.valid?
          render json: pet, status: :created
        else
          render json: ErrorSerializer.serialize(pet.errors), status: :unprocessable_entity
        end
      end

      def destroy
        @pet.destroy!
        render json: @pet
      end

      private
      def apply_filters(pets, filter)        
        if filter.try!(:[], :period)          
          pets
        else
          pets
        end
      end

      def find_pets
        @pets = current_user.pets.find_by_id(params[:id])
      end

      def find_pet
        @pet = Pet.find_by_id(params[:id])
      end

      def pets_params
        params.require(:data).require(:attributes).permit(:name, :level, :vertices, :user_id, :colour)
      end
    end
  end
end
