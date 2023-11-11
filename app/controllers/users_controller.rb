class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Acción para mostrar la lista de usuarios
  def index
    @users = User.all
  end

  # Acción para mostrar un usuario específico
  def show
    @user = User.find(params[:id])
    if @user.nil?
      # Manejo de caso en el que no se encuentra un usuario
      redirect_to users_path, alert: "Usuario no encontrado"
    end
  end

  # Acción para crear un nuevo usuario
  def new
    @user = User.new user_params
  end

  # Acción para editar un usuario
  def edit
  end

  # Acción para crear un nuevo usuario en la base de datos
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'Usuario creado exitosamente.'
    else
      render :new
    end
  end

  # Acción para actualizar un usuario en la base de datos
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Usuario actualizado exitosamente.'
    else
      render :edit
    end
  end

  # Acción para eliminar un usuario
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Usuario eliminado exitosamente.'
  end

  private

  # Método para encontrar un usuario por su ID
  def set_user
    @user = User.find(params[:id])
  end

  # Método para permitir los parámetros seguros al crear o actualizar un usuario
  def user_params
    params.fetch(:user, {}).permit( :email, :password , :avatar, :banner, :biography)
  end


  def posts
    @user = User.find(params[:id])
    @content_type = 'Posts'
    @content = @user.posts
    render 'show_content'
  end

  def comments
    @user = User.find(params[:id])
    @content_type = 'Comments'
    @content = @user.comments
    render 'show_content'
  end

  def show_content_params
    params.permit(:content_type)
  end


end
