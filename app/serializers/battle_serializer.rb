# require 'active_model_serializer'

class BattleSerializer < ActiveModel::Serializer
  attributes :id, :winner_id, :loser_id, :name, :challenged_email, :challenger_email, :status, :challenger_pet_id, :challenged_pet_id, :challenged_pet, :challenger_pet, :current_turn, :current_turn_email, :winner_email, :loser_email, :updated_at, :created_at

  has_many :users
  # has_many :pets, :through => :users
  has_many :pets

  has_one :state
  has_many :pet_states

  # def pets
  #   # [challenger_pet, challenged_pet] unless challenged_pet
  # end

  def current_turn
    object.state.current_turn
  end

  def created_at
    object.created_at.to_date()
  end

  def winner_email
    User.find_by_id(object.winner_id).email
  end

  def loser_email
    User.find_by_id(object.loser_id).email
  end

  def current_turn_email
    User.find_by_id(object.state.current_turn).try(:email)
  end

  def pet_states
    # this may not observe relationship
    # should have state across the actual ember model but lazy
    object.state.pet_states
  end

  def challenger_pet
    # serializer = PetSerializer.new(object.challenger_pet, {}).as_json
    # adapter = ActiveModel::Serializer::Adapter::FlattenJson.new(serializer)
    # adapter.to_json
    # render json: object.challenger_pet, serializer: PetSerializer, adapter: :json_api
    object.challenger_pet
  end

  def challenged_pet
    # serializer = PetSerializer.new(object.challenged_pet, {}).as_json
    # adapter = ActiveModel::Serializer::Adapter::FlattenJson.new(serializer)
    # adapter.to_json
    # render json: object.challenger_pet, serializer: PetSerializer, adapter: :json_api
    object.challenged_pet
  end
end
