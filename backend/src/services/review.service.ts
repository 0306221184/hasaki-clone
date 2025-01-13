import ReviewRepository from "../repositories/review.repository";

export default class ReviewService {
  private readonly repository: ReviewRepository;

  constructor(repository: ReviewRepository = new ReviewRepository()) {
    this.repository = repository;
  }

  public createReview = async ({
    product_id,
    user_id,
    rating,
    review_text,
  }) => {
    try {
      const review = await this.repository.createReview({
        product_id,
        user_id,
        rating,
        review_text,
      });
      return review;
    } catch (error) {
      throw error;
    }
  };

  public getReviews = async () => {
    try {
      const reviews = await this.repository.getReviews();
      return reviews;
    } catch (error) {
      throw error;
    }
  };
}
