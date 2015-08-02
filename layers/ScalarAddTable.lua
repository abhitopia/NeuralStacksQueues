local ScalarAddTable, parent = torch.class('nn.ScalarAddTable', 'nn.Module')

function ScalarAddTable:__init()
    parent.__init(self)
    self.gradInput = {torch.Tensor(), torch.Tensor()}
end

function ScalarAddTable:updateOutput(input)
    local vectors, scalars = unpack(input)
    self.output:repeatTensor(scalars, 1, vectors:size(2)):add(vectors)
    return self.output
end

function ScalarAddTable:updateGradInput(input, gradOutput)
    self.gradInput[1]:set(gradOutput)
    self.gradInput[2]:sum(gradOutput, 2)
    return self.gradInput
end
