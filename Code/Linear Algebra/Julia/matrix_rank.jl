include("draw_vectors.jl")

# A = [3 7 4 -1;
#      4 3 -1 5;
#      1 2 1 0]

A = 5*randn(3,4)




l = 1*norm(A)
set_theme!(theme_black())
fig = Figure(resolution=(1500,1200),fontsize=40)
ax = Axis3(fig[1,1],viewmode=:fit,
        title="rank(A)=$(rank(A))",protrusions=(0,0,0,200),
           limits=(-l,l,-l,l,-l,l),aspect=:data)
meshscatter!([0],[0],[0],color=:white,shading=false)
vectors!(A,color=:yellow)
plane!(A[:,1:2], color=(:cyan,0.6))
fig


