import SampleRepository from "../repositories/sample.repository";
export default class SampleService {
  private readonly repository: SampleRepository;
  constructor(repository: SampleRepository = new SampleRepository()) {
    this.repository = repository;
  }
  public sayHello(name: string): string {
    return `Hello ${name}`;
  }
}
