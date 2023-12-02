class AnswersController < ApplicationController
  before_action :set_question

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      flash[:success] = 'Answer created!'
      redirect_to question_path(@question, anchor: "ans-#{@answer.id}")
    else
      @question = @question.decorate
      @pagy, @answers = pagy @question.answers.order(created_at: :desc)
      @answers = @answers.decorate
      render 'questions/show'
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    flash[:success] = 'Question deleted!'
    redirect_to question_path(@question)
  end

  def edit
    @answer = @question.answers.find(params[:id])
  end

  def update
    @answer = @question.answers.find(params[:id])
    if @answer.update(answer_params)
      flash[:success] = 'Answer updated!'
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
