include("draw_vectors.jl")

A = [3 7;
     4 3;
     1 2]

b = [3;
    -5;
     3]

x = [-2;
     1.5]
# x = pinv(A)*b

v = A*x

l = 1.2*norm(A)
set_theme!(theme_black())
fig = Figure(resolution=(1500,1200),
             fontsize=40)
ax = Axis3(fig[1,1],viewmode=:fit,
           limits=(-l,l,-l,l,-l,l),
           aspect=:data)
vectors!(A,color=:yellow)
plane!(A, color=(:cyan,0.6))
vector!(b,color=:deeppink)
vector!(v,color=:orange)
vector!(0.8*(b-v),1.1*v,color=:cyan)
fig