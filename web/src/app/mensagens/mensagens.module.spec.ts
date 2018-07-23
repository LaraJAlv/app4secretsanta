import { MensagensModule } from './mensagens.module';

describe('MensagensModule', () => {
  let mensagensModule: MensagensModule;

  beforeEach(() => {
    mensagensModule = new MensagensModule();
  });

  it('should create an instance', () => {
    expect(mensagensModule).toBeTruthy();
  });
});
