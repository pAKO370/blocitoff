class ItemPolicy < ApplicationPolicy

attr_reader :current_user, :item

  def initialize(current_user, item)
    @current_user = current_user
    @item = item
  end

  def index?
    current_user
  end

  def show?
    @user == current_user 
  end

  def create?
    current_user
  end

  def new?
    create?
  end

  def update?
    current_user
  end

  def edit?
    current_user
  end

  def destroy?
    current_user
  end
  def destroy_multiple?
    current_user
  end
end

